<?php

/**
 * This is the model class for table "encargados_empresas".
 *
 * The followings are the available columns in table 'encargados_empresas':
 * @property string $pk
 * @property integer $empresa_fk
 * @property string $nombre
 * @property string $apellidos
 * @property string $genero
 * @property string $email
 * @property string $telefono
 *
 * The followings are the available model relations:
 * @property Empresas $empresaFk
 */
class EncargadosEmpresas extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return EncargadosEmpresas the static model class
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
		return 'encargados_empresas';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('empresa_fk, nombre, apellidos, email, telefono', 'required'),
			array('empresa_fk', 'numerical', 'integerOnly'=>true),
			array('nombre, apellidos, email', 'length', 'max'=>255),
			array('genero', 'length', 'max'=>1),
			array('telefono', 'length', 'max'=>50),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('pk, empresa_fk, nombre, apellidos, genero, email, telefono', 'safe', 'on'=>'search'),
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
			'empresaFk' => array(self::BELONGS_TO, 'Empresas', 'empresa_fk'),
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
			'nombre' => 'Nombre',
			'apellidos' => 'Apellidos',
			'genero' => 'Genero',
			'email' => 'Email',
			'telefono' => 'Telefono',
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
		$criteria->compare('nombre',$this->nombre,true);
		$criteria->compare('apellidos',$this->apellidos,true);
		$criteria->compare('genero',$this->genero,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('telefono',$this->telefono,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}