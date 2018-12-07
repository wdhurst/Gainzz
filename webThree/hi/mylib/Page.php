<?php

namespace mylib;

require_once "Generator.php";

class Page extends Generator {
    public function doctype() {
        echo "<!DOCTYPE html>\n";
    }
    public function page() {
        $this->doctype();
        $this->html();
    }
    public function html() {
        echo "<html>\n";
        $this->nav();
        $this->head();
        $this->body();
        echo "</html>\n";        
    }
    public function nav(){
        echo "<nav>";
        echo "<a href=\"/\">Home </a>";
        echo "<a href=\"/Menu.php/\"> Menu </a>";
        echo "<a href=\"/About.php/\"> About </a>";
        echo "</nav>";
    }
    public function head() {
        echo "<head>\n";
        $this->title();
        echo "</head>\n";        
    }
    public function body() {
        echo "<body>\n";
        $this->content();
        echo "</body>\n";        
    }
    public function title() {
        echo "title";
    }
    public function content() {
        echo "content\n";
    }
    public function generate() {
        $this->page();
    }
}