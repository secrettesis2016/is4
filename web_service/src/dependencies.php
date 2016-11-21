<?php

$container = $app->getContainer();

// view renderer
$container['renderer'] = function ($c) {
    $settings = $c->get('settings')['renderer'];
    return new Slim\Views\PhpRenderer($settings['template_path']);
};

// monolog
$container['logger'] = function ($c) {
    $settings = $c->get('settings')['logger'];
    $logger = new Monolog\Logger($settings['name']);
    $logger->pushProcessor(new Monolog\Processor\UidProcessor());
    $logger->pushHandler(new Monolog\Handler\StreamHandler($settings['path'], Monolog\Logger::DEBUG));
    return $logger;
};

// Database
$container['db'] = function($c){
    $connectionString = $c->get('settings')['connectionString'];
    
    $pdo = new PDO($connectionString['dns'], $connectionString['user'], $connectionString['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);

    return $pdo; 
};

// Models
$container['model'] = function($c){
    return (object)[

        'producto' =>  new App\Model\ProductoModel($c->db),
        'iva' =>  new App\Model\IvaModel($c->db),
        'categoria' =>  new App\Model\CategoriaModel($c->db),
        'pais' =>  new App\Model\PaisModel($c->db),
        'ciudad' =>  new App\Model\CiudadModel($c->db),
        'barrio' =>  new App\Model\BarrioModel($c->db),
        'tipo_documento' =>  new App\Model\TipoDocumentoModel($c->db),
        'persona' =>  new App\Model\PersonaModel($c->db),
        'persona_tipo' =>  new App\Model\PersonaTipoModel($c->db),        
        'tipo_persona' =>  new App\Model\TipoDePersonaModel($c->db),




    ];
};