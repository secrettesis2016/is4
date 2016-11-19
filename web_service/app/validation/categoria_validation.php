<?php
namespace App\Validation;

use App\Lib\Response;

class CategoriaValidation {
    public static function validate($data) {
        $response = new Response();

        $key = 'nombre';
        if(empty($data[$key])) {
            $response->errors[$key][] = 'Este campo es obligatorio';
        }

        $response->setResponse(count($response->errors) === 0);

        return $response;
}
}
