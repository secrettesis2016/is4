<?php
use App\Lib\Auth,
    App\Lib\Response,
    App\Validation\TestValidation,
    App\Middleware\AuthMiddleware;



$app->group('/persona_tipo/', function () {
    $this->get('getAll', function ($req, $res, $args) {
		$clase='persona_tipo';
		return $res->withHeader('Content-type', 'application/json')
				->write(
					json_encode($this->model->$clase->getAll())
					);
    });
	
	$this->get('get/{id}', function ($req, $res, $args) {
		$clase='persona_tipo';
		return $res->withHeader('Content-type', 'application/json')
				->write(
					json_encode($this->model->$clase->get($args['id']))
					);
    });
	
	$this->post('insert', function ($req, $res, $args) {
		$clase='persona_tipo';
		return $res->withHeader('Content-type', 'application/json')
				->write(
					json_encode($this->model->$clase->insert($req->getParsedBody()))
					);
    });
	
	$this->put('update/{id}', function ($req, $res, $args) {
		$clase='persona_tipo';
		return $res->withHeader('Content-type', 'application/json')
				->write(
					json_encode($this->model->$clase->update($req->getParsedBody(), $args['id']))
					);
    });
	
	$this->delete('delete/{id}', function ($req, $res, $args) {
		$clase='persona_tipo';
		return $res->withHeader('Content-type', 'application/json')
				->write(
					json_encode($this->model->$clase->delete($args['id']))
					);
    });
});