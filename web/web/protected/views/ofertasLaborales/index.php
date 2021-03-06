<?php
/* @var $this OfertasLaboralesController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Ofertas Laborales',
);

?>
<?php
$this->menu=array(
        array('label'=>'Buscar', 'url'=>array('#')),
	array('label'=>'Publicar una Oferta Laboral', 'url'=>array('ofertasLaborales/create'), 'visible'=>!Yii::app()->user->isGuest),
	array('label'=>'Publicar Practica', 'url'=>array('#'), 'visible'=>!Yii::app()->user->isGuest),
);
?>

<h1>Ofertas Laborales</h1>

<?php 
    $this->widget('ext.groupgridview.GroupGridView', array(
      'id' => 'grid1',
      'dataProvider' => $dp,
      'mergeColumns' => array('fecha_publicacion', 'rubro_fk'),
      'columns' => array(
          'fecha_publicacion',
          array(
              'header'=>'Rubro',
              'name'=>'rubro_fk',
              'value' => '$data->rubroFk->rubro',
          ),
          'cargo',
          array(
              'header'=>'Nivel de estudios Deseable',
              'name'=>'nivel_estudio_fk',
              'value' => '$data->nivelEstudioFk->estudios',
          ),
        array(
            'header'=>'Revisar',
            'class'=>'CButtonColumn',
            'template'=>'{view}',
    ),    
      ),
    ));
?>
