<?php
/* @var $this TiposContratosController */
/* @var $model TiposContratos */

$this->breadcrumbs=array(
	'Tipos Contratoses'=>array('index'),
	$model->pk=>array('view','id'=>$model->pk),
	'Update',
);

$this->menu=array(
	array('label'=>'List TiposContratos', 'url'=>array('index')),
	array('label'=>'Create TiposContratos', 'url'=>array('create')),
	array('label'=>'View TiposContratos', 'url'=>array('view', 'id'=>$model->pk)),
	array('label'=>'Manage TiposContratos', 'url'=>array('admin')),
);
?>

<h1>Update TiposContratos <?php echo $model->pk; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>