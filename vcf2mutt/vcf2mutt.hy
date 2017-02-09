#!/usr/bin/env hy

(import [os]
        [sys]
        [codecs]
        [signal [signal SIGPIPE SIG_DFL]]
        [requests]
        [vobject])

; https://stackoverflow.com/questions/492483/setting-the-correct-encoding-when-piping-stdout-in-python
(reload sys)
(sys.setdefaultencoding "utf8")

; https://stackoverflow.com/a/16865106/2131094
(signal SIGPIPE SIG_DFL)

(defn fetch-vcards [url]
  (try
    ; test for a local file
    (if (os.path.isfile url)
      ; try to load the file locally
      (-> (codecs.open url :encoding "utf8")
          (.read))
      ; try to fetch raw contacts from the URL supplied
      (let [request (requests.get url)]
        (setv request.encoding "utf8")
        request.text))
    (except [e Exception]
            (sys.exit e))))

(defn get-fullname [contact]
  (if (hasattr contact "fn")
    (. (getattr contact "fn") value)
    ""))

(defn parse-vcards [raw-vcards]
  (list-comp [(. contact email value) (get-fullname contact)]
             [contact (vobject.readComponents raw-vcards)]
             (hasattr contact "email")))

(defn mutt-alias-format [vcards]
  (.join "\n" (list-comp (% "alias %s %s %s" (, (get (.split email "@") 0) fullname email)) [[email fullname] vcards])))

(defn usage [args]
  (print "Usage:" (get args 0) "https://USERNAME:PASSWORD@SERVER/.../contacts.vcf"))

(defn main [args]
  (if (<= (len args) 1)
    (usage args)
    (print (-> (fetch-vcards (get args 1))
               (parse-vcards)
               (mutt-alias-format)))))

(defmain [&rest args]
  (main args))
