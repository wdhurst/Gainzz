<?php

require_once "mylib/Page.php";

class HomePage extends mylib\Page {
    public function title() { echo "Home Page!\n<br>"; }
    public function content() { echo "Main content goes here!"; }
}

$page = new HomePage();
$page->generate();