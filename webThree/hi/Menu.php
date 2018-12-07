<?php

require_once "mylib/Page.php";

class MenuPage extends mylib\Page {
    public function title() { echo "Menu Page!\n <br>"; }
    public function content() { echo "Items go Here!"; }
}

$page = new MenuPage();
$page->generate();