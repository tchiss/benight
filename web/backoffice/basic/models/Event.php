<?php

namespace app\models;

use yii\grid\GridView;
use \yii\data\ActiveDataProvider;
use \yii\parse\ActiveRecord;

class Event extends ActiveRecord
{
    public static function tableName() 
    {
        return 'Event';
    }

    /**
    * Be sure to add in the model so as parse can not return fileds class.
    */
    public static function columns()
    {
        return ['objectId', 'author', 'date', 'location', 'role', 'name', 'updated_at'];
    }

    public function attributeLabels()
    {
        return [];
    }

    public function scenarios()
    {
        return parent::scenarios();
    }

    public function search($params)
    {
        /* @var $query \yii\parse\ActiveQuery */

        $calss = get_class();
        $query = $calss::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'sort' => [
                'defaultOrder' => [
                    'author' => SORT_ASC, 
                ]
            ],
            'pagination' => [
                'pageSize' => 5,
            ],
        ]);

        $this->load($params);

        foreach (array_keys($this->getAttributes()) as $attribute) {
            if (is_numeric($this->$attribute)) {
                $query->andFilterWhere(['=', $attribute, $this->$attribute]);
            } else {
                $query->andFilterWhere(['like', $attribute, $this->$attribute]);
            }
        }

        return $dataProvider;
    }
}
