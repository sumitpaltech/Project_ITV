<?php

namespace App\Support;

class PythonPasswordHasher
{
    public static function check(string $plain, string $stored): bool
    {
        if (! str_contains($stored, '$')) return false;
        $parts = explode('$', $stored, 3);
        if (count($parts) !== 3) return false;
        [$method, $salt, $hash] = $parts;

        if (str_starts_with($method, 'scrypt:')) {
            $p = explode(':', $method);
            if (count($p) < 4) return false;
            [, $n, $r, $par] = $p;

            try {
                $computed = Scrypt::hash($plain, $salt, (int) $n, (int) $r, (int) $par, 64);
            } catch (\Throwable $e) {
                return false;
            }
            return hash_equals(strtolower($hash), strtolower($computed));
        }

        if (str_starts_with($method, 'pbkdf2:')) {
            $p = explode(':', $method);
            if (count($p) < 3) return false;
            [, $algo, $iter] = $p;
            $computed = hash_pbkdf2($algo, $plain, $salt, (int) $iter);
            return hash_equals(strtolower($hash), strtolower($computed));
        }

        return false;
    }
}
