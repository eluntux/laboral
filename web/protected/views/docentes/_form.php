<?php
/* @var $this DocentesController */
/* @var $model Docentes */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'docentes-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'nombres'); ?>
		<?php echo $form->textField($model,'nombres',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'nombres'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'apellidos'); ?>
		<?php echo $form->textField($model,'apellidos',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'apellidos'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_nacimiento'); ?>
		<?php echo $form->textField($model,'fecha_nacimiento'); ?>
		<?php echo $form->error($model,'fecha_nacimiento'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'genero'); ?>
		<?php echo $form->textField($model,'genero',array('size'=>1,'maxlength'=>1)); ?>
		<?php echo $form->error($model,'genero'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'direccion'); ?>
		<?php echo $form->textField($model,'direccion',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'direccion'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'comuna_id'); ?>
		<?php echo $form->textField($model,'comuna_id'); ?>
		<?php echo $form->error($model,'comuna_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'ec_fk'); ?>
		<?php echo $form->textField($model,'ec_fk'); ?>
		<?php echo $form->error($model,'ec_fk'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'departamento_fk'); ?>
		<?php echo $form->textField($model,'departamento_fk'); ?>
		<?php echo $form->error($model,'departamento_fk'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'telefono'); ?>
		<?php echo $form->textField($model,'telefono',array('size'=>50,'maxlength'=>50)); ?>
		<?php echo $form->error($model,'telefono'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'celular'); ?>
		<?php echo $form->textField($model,'celular',array('size'=>50,'maxlength'=>50)); ?>
		<?php echo $form->error($model,'celular'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'email'); ?>
		<?php echo $form->textField($model,'email',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'email'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->