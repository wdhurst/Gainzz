<?php

require_once "mylib/Page.php";

class AboutPage extends mylib\Page {
    public function title() { echo "About us!\n <br>"; }
    public function content() { echo "Things about us go here!"; }
}

$page = new AboutPage();
$page->generate();