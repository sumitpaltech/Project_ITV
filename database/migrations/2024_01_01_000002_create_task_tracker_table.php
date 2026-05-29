<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('task_tracker', function (Blueprint $table) {
            $table->id();
            $table->string('title', 200);
            $table->text('description')->nullable();
            $table->string('category', 100)->default('General')->nullable();
            $table->string('department', 100)->nullable();
            $table->string('assigned_to', 100)->nullable();
            $table->string('user_mail', 255)->nullable();
            $table->string('team_member', 100)->nullable();
            $table->enum('priority', ['low', 'medium', 'high'])->default('medium');
            $table->date('start_date')->nullable();
            $table->date('due_date')->nullable();
            $table->date('completion_date')->nullable();
            $table->enum('status', ['pending', 'in_progress', 'completed', 'cancelled'])->default('pending');
            $table->text('remarks')->nullable();
            $table->text('file_attachment')->nullable();
            $table->timestamps();

            $table->index('assigned_to');
            $table->index('department');
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('task_tracker');
    }
};
