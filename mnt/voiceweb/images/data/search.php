<?php

// search php

header("Content-type:text/html;charset=iso-8859-2");

// Backward compatibility
if (isset($HTTP_GET_VARS)) {
  $_GET = $HTTP_GET_VARS;
}

setlocale(LC_ALL, 'hu_HU');

// Character encoding independent escape
function webmaEscape($str) {
  $str = str_replace('/', '', $str);
  $str = str_replace('<', '', $str);
  $str = str_replace('>', '', $str);
  return $str;
}

if (isset($_GET['idb']) &&
    isset($_GET['keyword']) &&
    isset($_GET['encoding'])) {

  // Escaping input data
  $_GET['idb'] = webmaEscape(trim($_GET['idb']));
  $_GET['encoding'] = webmaEscape(trim($_GET['encoding']));

  if (!file_exists($_GET['encoding'] . '.php')) { exit; }
  require $_GET['encoding'] . '.php';
  $_GET['keyword'] = webmaEscape(trim($_GET['keyword']));
  $_GET['keyword'] = str_replace(" ","XXXXX", $_GET['keyword']);
  $_GET['keyword'] = str_replace("-","YYYYY", $_GET['keyword']);
  $_GET['keyword'] = preg_replace("/[^\w" . $accents . "]*/", "", $_GET['keyword']);
  $_GET['keyword'] = str_replace("XXXXX"," ", $_GET['keyword']);
  $_GET['keyword'] = str_replace("YYYYY","-", $_GET['keyword']);
  if ("" == trim($_GET['keyword'])) {
    exit;
  }

  $idb_path = "./" . $_GET['idb'];

  // Reading database line by line
  $idb = fopen($idb_path, 'r');
  $num_of_matches = 0;
  $o = "";

  while (!feof($idb)) {
    $page = fgets($idb, 65535);
    // Exit on newline
    if (trim($page) == "") { break; }
    // Exploding
    list($url, $title, $body) = explode('^', $page);
    // Searching
    $valid_word = "\w\d&;.,?!" . $accents . "-";
    if (stristr($body, $_GET['keyword'])) {
      ##$regex = "/\b(?P<before>.{0,50})\b(?P<keyword>[" . $valid_word ."]*" . $_GET['keyword'] . "[" . $valid_word . "]*)\b(?P<after>.{0,30})\b/i";
      $regex = "/\b(.{0,50})\b([" . $valid_word ."]*?" . $_GET['keyword'] . "[" . $valid_word . "]*?)\b(.{0,50})\b/i";
      if (preg_match($regex, $body, $matches)) {
	++$num_of_matches;
	// HTML output
	 $matches['before'] = $matches[1];
	 $matches['keyword'] = $matches[2];
	 $matches['after'] = $matches[3];
	$o .= "<li><p><strong><a href=\"$url\">" . trim($title) . "</a></strong><br />";
	$o .= "&hellip;" . $matches['before'] . "<strong class=\"search-result\">" . $matches['keyword'] . "</strong>" . $matches['after'] . "&hellip;</p></li>";
      }
    }
  }
  fclose($idb);

  print ("<h1 id=\"search-header\">" . $lbl['num_of_matches'] . ": " . $num_of_matches . "</h1>");
  print ("<ul>" . $o . "</ul>");

}

?>
