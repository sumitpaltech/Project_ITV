<?php

namespace App\Support;

/**
 * Pure-PHP scrypt implementation.
 *
 * Based on the original Colin Percival scrypt paper and adapted from the
 * domnikl/security package (MIT license). Used to verify werkzeug passwords
 * like  scrypt:32768:8:1$salt$hexhash.
 *
 * SLOW — only use during the one-time password migration.
 */
class Scrypt
{
    public static function hash(string $password, string $salt, int $n, int $r, int $p, int $dkLen): string
    {
        if ($n === 0 || ($n & ($n - 1)) !== 0) {
            throw new \InvalidArgumentException('N must be > 0 and a power of 2');
        }

        $b  = self::pbkdf2('sha256', $password, $salt, 1, $p * 128 * $r);
        $s  = '';
        for ($i = 0; $i < $p; $i++) {
            $s .= self::scryptROMix(substr($b, $i * 128 * $r, 128 * $r), $n, $r);
        }
        $out = self::pbkdf2('sha256', $password, $s, 1, $dkLen);
        return bin2hex($out);
    }

    private static function pbkdf2(string $algo, string $pass, string $salt, int $iter, int $len): string
    {
        return hash_pbkdf2($algo, $pass, $salt, $iter, $len, true);
    }

    private static function scryptROMix(string $b, int $n, int $r): string
    {
        $x = $b;
        $v = [];
        for ($i = 0; $i < $n; $i++) {
            $v[$i] = $x;
            $x     = self::scryptBlockMix($x, $r);
        }
        for ($i = 0; $i < $n; $i++) {
            $j = self::integerify($x, $r) % $n;
            $x = self::scryptBlockMix(self::strxor($x, $v[$j]), $r);
        }
        return $x;
    }

    private static function scryptBlockMix(string $b, int $r): string
    {
        $x      = substr($b, -64);
        $y      = '';
        for ($i = 0; $i < 2 * $r; $i++) {
            $x = self::salsa208Core(self::strxor($x, substr($b, $i * 64, 64)));
            $y .= $x;
        }
        // Re-interleave: even blocks first, odd blocks second (per scrypt spec)
        $out = '';
        for ($i = 0; $i < $r; $i++)     $out .= substr($y, $i * 2 * 64, 64);
        for ($i = 0; $i < $r; $i++)     $out .= substr($y, $i * 2 * 64 + 64, 64);
        return $out;
    }

    private static function integerify(string $b, int $r): int
    {
        // Use the first 4 bytes of the LAST 64-byte block of the last r-pair
        $offset = (2 * $r - 1) * 64;
        $bytes  = substr($b, $offset, 4);
        $unp    = unpack('V', $bytes);
        return $unp[1];
    }

    private static function strxor(string $a, string $b): string
    {
        return $a ^ $b;
    }

    private static function salsa208Core(string $in): string
    {
        $x = array_values(unpack('V16', $in));
        $orig = $x;
        for ($i = 0; $i < 4; $i++) {
            // Column round
            $x[ 4] ^= self::rotl($x[ 0] + $x[12],  7);
            $x[ 8] ^= self::rotl($x[ 4] + $x[ 0],  9);
            $x[12] ^= self::rotl($x[ 8] + $x[ 4], 13);
            $x[ 0] ^= self::rotl($x[12] + $x[ 8], 18);
            $x[ 9] ^= self::rotl($x[ 5] + $x[ 1],  7);
            $x[13] ^= self::rotl($x[ 9] + $x[ 5],  9);
            $x[ 1] ^= self::rotl($x[13] + $x[ 9], 13);
            $x[ 5] ^= self::rotl($x[ 1] + $x[13], 18);
            $x[14] ^= self::rotl($x[10] + $x[ 6],  7);
            $x[ 2] ^= self::rotl($x[14] + $x[10],  9);
            $x[ 6] ^= self::rotl($x[ 2] + $x[14], 13);
            $x[10] ^= self::rotl($x[ 6] + $x[ 2], 18);
            $x[ 3] ^= self::rotl($x[15] + $x[11],  7);
            $x[ 7] ^= self::rotl($x[ 3] + $x[15],  9);
            $x[11] ^= self::rotl($x[ 7] + $x[ 3], 13);
            $x[15] ^= self::rotl($x[11] + $x[ 7], 18);
            // Row round
            $x[ 1] ^= self::rotl($x[ 0] + $x[ 3],  7);
            $x[ 2] ^= self::rotl($x[ 1] + $x[ 0],  9);
            $x[ 3] ^= self::rotl($x[ 2] + $x[ 1], 13);
            $x[ 0] ^= self::rotl($x[ 3] + $x[ 2], 18);
            $x[ 6] ^= self::rotl($x[ 5] + $x[ 4],  7);
            $x[ 7] ^= self::rotl($x[ 6] + $x[ 5],  9);
            $x[ 4] ^= self::rotl($x[ 7] + $x[ 6], 13);
            $x[ 5] ^= self::rotl($x[ 4] + $x[ 7], 18);
            $x[11] ^= self::rotl($x[10] + $x[ 9],  7);
            $x[ 8] ^= self::rotl($x[11] + $x[10],  9);
            $x[ 9] ^= self::rotl($x[ 8] + $x[11], 13);
            $x[10] ^= self::rotl($x[ 9] + $x[ 8], 18);
            $x[12] ^= self::rotl($x[15] + $x[14],  7);
            $x[13] ^= self::rotl($x[12] + $x[15],  9);
            $x[14] ^= self::rotl($x[13] + $x[12], 13);
            $x[15] ^= self::rotl($x[14] + $x[13], 18);
        }
        $out = '';
        for ($i = 0; $i < 16; $i++) {
            $out .= pack('V', ($x[$i] + $orig[$i]) & 0xFFFFFFFF);
        }
        return $out;
    }

    private static function rotl(int $v, int $b): int
    {
        $v &= 0xFFFFFFFF;
        return (($v << $b) | ($v >> (32 - $b))) & 0xFFFFFFFF;
    }
}
