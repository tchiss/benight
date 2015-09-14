<?php
use yii\helpers\Html;
use yii\widgets\LinkPager;
use app\models\Event;
use \yii\data\ActiveDataProvider;
use \yii\parse\ActiveRecord;
use yii\grid\GridView;
?>
<h1>Events</h1>
<ul>

<?php 
    $query = Event::find();

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


echo GridView::widget([
    'dataProvider' => $dataProvider,
    'columns' => [
        ['class' => 'yii\grid\SerialColumn'],
        'name',
        'author',
    ],
]);?>
</ul>

<?php 
LinkPager::widget(['pagination' => $pagination]) ?>
