<?php

/**
 * This is the model class for table "ofertas_laborales".
 *
 * The followings are the available columns in table 'ofertas_laborales':
 * @property string $pk
 * @property integer $empresa_fk
 * @property integer $rubro_fk
 * @property integer $nivel_estudio_fk
 * @property string $renta
 * @property integer $vacantes
 * @property string $plazo
 * @property string $descripcion
 * @property string $ubicacion
 * @property string $cargo
 * @property string $fecha_publicacion
 * @property string $beneficios
 * @property string $nivel_estudios
 * @property integer $jornada_fk
 * @property integer $contrato_fk
 * @property integer $activo
 */
class Ofertas extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Ofertas the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'ofertas_laborales';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('empresa_fk, rubro_fk, nivel_estudio_fk, renta, vacantes, descripcion, cargo, fecha_publicacion, nivel_estudios, jornada_fk, contrato_fk', 'required'),
			array('empresa_fk, rubro_fk, nivel_estudio_fk, vacantes, jornada_fk, contrato_fk, activo', 'numerical', 'integerOnly'=>true),
			array('renta', 'length', 'max'=>10),
			array('descripcion, ubicacion, cargo, beneficios, nivel_estudios', 'length', 'max'=>255),
			array('plazo', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('pk, empresa_fk, rubro_fk, nivel_estudio_fk, renta, vacantes, plazo, descripcion, ubicacion, cargo, fecha_publicacion, beneficios, nivel_estudios, jornada_fk, contrato_fk, activo', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'pk' => 'Pk',
			'empresa_fk' => 'Empresa Fk',
			'rubro_fk' => 'Rubro Fk',
			'nivel_estudio_fk' => 'Nivel Estudio Fk',
			'renta' => 'Renta',
			'vacantes' => 'Vacantes',
			'plazo' => 'Plazo',
			'descripcion' => 'Descripcion',
			'ubicacion' => 'Ubicacion',
			'cargo' => 'Cargo',
			'fecha_publicacion' => 'Fecha Publicacion',
			'beneficios' => 'Beneficios',
			'nivel_estudios' => 'Nivel Estudios',
			'jornada_fk' => 'Jornada Fk',
			'contrato_fk' => 'Contrato Fk',
			'activo' => 'Activo',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('pk',$this->pk,true);
		$criteria->compare('empresa_fk',$this->empresa_fk);
		$criteria->compare('rubro_fk',$this->rubro_fk);
		$criteria->compare('nivel_estudio_fk',$this->nivel_estudio_fk);
		$criteria->compare('renta',$this->renta,true);
		$criteria->compare('vacantes',$this->vacantes);
		$criteria->compare('plazo',$this->plazo,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('ubicacion',$this->ubicacion,true);
		$criteria->compare('cargo',$this->cargo,true);
		$criteria->compare('fecha_publicacion',$this->fecha_publicacion,true);
		$criteria->compare('beneficios',$this->beneficios,true);
		$criteria->compare('nivel_estudios',$this->nivel_estudios,true);
		$criteria->compare('jornada_fk',$this->jornada_fk);
		$criteria->compare('contrato_fk',$this->contrato_fk);
		$criteria->compare('activo',$this->activo);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}