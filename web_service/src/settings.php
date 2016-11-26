<?php
return [
    'settings' => [
        'displayErrorDetails' => true,

        // Renderer settings
        'renderer' => [
            'template_path' => __DIR__ . '/../templates/',
        ],

        // Monolog settings
        'logger' => [
            'name' => 'slim-app',
            'path' => __DIR__ . '/../logs/app.log',
        ],
        
        // Configuración de mi APP
        'app_token_name'   => 'APP-TOKEN',
        'connectionString' => [
            'dns'  => 'pgsql:host=52.67.57.33;dbname=stock_manager',
            'user' => 'postgres',
            'pass' => 'apy2016'
        ]
    ],
];
