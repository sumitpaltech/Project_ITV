<?php

namespace Tests\Feature;

use Tests\TestCase;

class HealthCheckTest extends TestCase
{
    /** @test */
    public function health_endpoint_returns_ok(): void
    {
        $response = $this->getJson('/health');

        $response->assertStatus(200)
                 ->assertJsonStructure(['status', 'timestamp'])
                 ->assertJson(['status' => 'ok']);
    }

    /** @test */
    public function readiness_endpoint_checks_database(): void
    {
        $response = $this->getJson('/ready');

        // In test env with SQLite, this should pass
        $response->assertStatus(200)
                 ->assertJson(['status' => 'ready']);
    }
}
