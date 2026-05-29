<?php

/*
 |--------------------------------------------------------------------------
 | Department Heads
 |--------------------------------------------------------------------------
 |
 | Converted from Python config/department.py + dashboard_controller.py
 | Username => is head of => Department
 |
 | A department head can see every task in their department.
 | Other users see only the tasks assigned to their username.
 |
 */

return [

    'heads' => [
        'Admin'                   => 'Sumit',
        'IT'                      => 'Bala',
        'Data Analyst'            => 'Mayank Sir',
        'Accounts'                => 'Kanaiyalal',
        'Marketing'               => 'Divya',
        'Digital Marketing'       => 'Divya',
        'Tender'                  => 'Divya',
        'Technical'               => 'Devendra',
        'Sales'                   => 'Divya',
        'Supply Chain Management' => 'Divya',
        'Services'                => 'Divya',
        'Ecommerce'               => 'Mayank Sir',
        'Dispatch'                => 'Mayank Sir',
        'Costing'                 => 'Mayank Sir',
        'HR'                      => 'Mayank Sir',
        'Zoho'                    => 'Sadique',
    ],

    /*
     | Used for the registration dropdown and filters.
     */
    'list' => [
        'Admin',
        'Business Intelligence',
        'Accounts',
        'Design',
        'Product Design',
        'Technical',
        'Tender',
        'Services',
        'Digital Marketing',
        'Ecommerce',
        'Dispatch',
        'Marketing',
        'Costing',
        'IT',
        'Sales & Marketing',
        'Supply Chain Management',
        'New Project',
        'HR',
        'Zoho',
        'Data Analyst',
    ],

];
