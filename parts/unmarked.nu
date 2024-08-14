use std log

def main [...files: string] {
  if ($files | is-empty) {
    log error "No files provided"
    exit 1
  }

  let results = $files | each { |file|
    let unmarked_payees = (hledger payees --unmarked -f $file | lines | where { |line| $line != "" })
    $unmarked_payees | each { |line|
      let search_result = (search_file $file $line)
      if ($search_result | length) > 0 {
        let first_match = ($search_result | first)
        {
          file: $file,
          line_number: $first_match.line_number,
          payee: $line
        }
      } else {
        {
          file: $file,
          line_number: null,
          payee: $line
        }
      }
    }
  } | flatten

  if ($results | length) > 0 {
    $results | each { |result|
      if $result.line_number != null {
        log error $" File ($result.file):($result.line_number) Unmarked transaction: ($result.payee)"
      } else {
        log error $" File ($result.file) error: Unmarked transaction: ($result.payee)"
      }
    }
    print $"\n\n(ansi cyan_bold)Help:(ansi reset) Add a ! for pending or a * for cleared transactions"
    print $"\n see https://hledger.org/1.34/hledger.html#status"
    exit 1
  } else {
    exit 0
  }
}

def is_payee_line [line: string, payee: string] {
  let parts = ($line | str trim | split row " ")
  if ($parts | length) >= 2 {
    let date = $parts.0
    let potential_payee = ($parts | skip 1 | str join " ")
    let is_date = ($date | parse "{year}-{month}-{day}" | length) == 1
    let contains_payee = ($potential_payee | str contains $payee)
    let no_special_chars = (not ($potential_payee | str starts-with "!")) and (not ($potential_payee | str starts-with "*"))
    $is_date and $contains_payee and $no_special_chars
  } else {
    false
  }
}

def search_file [file: string, payee: string] {
  open $file
  | lines
  | enumerate
  | where { |line|
      (not ($line.item | str trim | str starts-with "#")) and (not ($line.item | str trim | str starts-with ";")) and (is_payee_line $line.item $payee)
  }
  | each { |match| {
      file: $file,
      line_number: ($match.index + 1),
      content: $match.item
    }}
}

