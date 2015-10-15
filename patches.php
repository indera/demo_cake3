<?php

// == config/routes.php

// New route we're adding for our tagged action.
// The trailing `*` tells CakePHP that this action has
// passed parameters.
Router::scope(
    '/bookmarks',
    ['controller' => 'Bookmarks'],
    function ($routes) {
        $routes->connect('/tagged/*', ['action' => 'tags']);
    }
);


// == src/Controller/BookmarksController.php 

public function tags()
{
    // The 'pass' key is provided by CakePHP and contains all
    // the passed URL path segments in the request.
    $tags = $this->request->params['pass'];

    // Use the BookmarksTable to find tagged bookmarks.
    $bookmarks = $this->Bookmarks->find('tagged', [
        'tags' => $tags
    ]);

    // Pass variables into the view template context.
    $this->set([
        'bookmarks' => $bookmarks,
        'tags' => $tags
    ]);
}



// == src/Model/Table/BookmarksTable.php

// The $query argument is a query builder instance.
// The $options array will contain the 'tags' option we passed
// to find('tagged') in our controller action.
public function findTagged(Query $query, array $options)
{
    return $this->find()
        ->distinct(['Bookmarks.id'])
        ->matching('Tags', function ($q) use ($options) {
            return $q->where(['Tags.title IN' => $options['tags']]);
        });
}


// == src/Template/Bookmarks/tags.ctp

/*
<h1>
    Bookmarks tagged with
    <?= $this->Text->toList($tags) ?>
</h1>

<section style="padding: 2em">
<?php
foreach ($bookmarks as $bookmark) { ?>
    <article>
        <!-- Use the HtmlHelper to create a link -->
        <h4><?= $this->Html->link($bookmark->title, $bookmark->url) ?></h4>
        <small><?= h($bookmark->url) ?></small>

        <!-- Use the TextHelper to format text -->
        <?= $this->Text->autoParagraph($bookmark->description) ?>
    </article>
<?php 
}
?>
</section>
*/
