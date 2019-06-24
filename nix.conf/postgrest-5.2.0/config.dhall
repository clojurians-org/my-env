  {
      db-uri = ""
    , db-anon-role = ""
    , server-proxy-uri = None Text
      {-- this schema gets added to the search_path of every request --}
    , db-schema = "public"
    , server-host = "127.0.0.1"
    , server-port = 3000

    , jwt-secret = None Text
    , secret-is-base64 = False
    , jwt-aud = None Text

    , db-pool = 10
    , db-pool-timeout = 10
    , max-rows = Some 1000
    , pre-request = None Text
    , quiet = False
    , app-settings = [] : List (List Text)
    , role-claim-key = None Text
    , db-extra-search-path = ["extensions"]
  } // {
      db-uri = "postgres://monitor:monitor@10.132.37.200:5432/monitor"
    , db-schema =  "public"
    , db-anon-role = "monitor"
    , server-host = "10.132.37.200"
    , server-port = 3001
    {--
    , server-proxy-uri = Optional "http://localhost:8118"
    , jwt-secret = "foo"
    , secret-is-base64= True
    , jwt-aud = "your_audience_claim"

    , max-rows = 10000

    , pre-request = "stored_proc_name"

    , role-claim-key = ".role"
    , db-extra-search-path = ["extensions", "util"]
    --}
    }
