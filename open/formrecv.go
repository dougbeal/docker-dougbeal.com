package main

import (
	"time"
	"encoding/json"
	"fmt"
	"github.com/rs/formjson"
	"github.com/kennygrant/sanitize"
	"log"
	"net/http"
	"net/http/httputil"
	"os"
	"text/template"
	"path"
)

func fatalError( msg string, err error, w http.ResponseWriter ) {
	errorHtml := fmt.Sprintf("<html>failured to create file: %s.  Try going back and changing title?!?!?</html>", err)
	log.Println(errorHtml)
	w.Write([]byte(errorHtml))
}

func main() {
	h := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		inputFields := []string{"name", "panelType", "hidden-good-times-input", "hidden-bad-times-input", "mc", "title", "tagline", "description"}

		outputDirectory := os.Getenv("OPENSPACE_MARKDOWN_TARGET")
		filename := sanitize.Path(r.FormValue("title")) + "_" + sanitize.Path(r.FormValue("name"))
		

		if len(outputDirectory) == 0 {
			outputDirectory = "."
		}
		dump, err := httputil.DumpRequest(r, true)
		log.Println(string(dump))


		Data := make(map[string]interface{})
		for _, field :=  range inputFields {
			Data[field] = string(r.FormValue(field))
		}
		// [{"id":"saturday_4pm_columbia-a/1"},{"id":"saturday_5pm_columbia-a/1"},{"id":"saturday_9pm_columbia-a/1"},{"id":"saturday_2pm_columbia-b/2"},{"id":"saturday_3pm_columbia-b/2"},{"id":"saturday_5pm_columbia-b/2"},{"id":"saturday_8pm_columbia-b/2"},{"id":"saturday_9pm_columbia-b/2"},{"id":"sunday_10am_columbia-a/1"},{"id":"sunday_11am_columbia-a/1"},{"id":"sunday_10am_columbia-b/2"},{"id":"sunday_11am_columbia-b/2"}]
		log.Println(r.FormValue("title"))
		log.Println(Data["title"])
		var goodTimes []map[string]string
		str := r.FormValue("hidden-good-times-input")
		delete(Data, "hidden-good-times-input")
		if str == "[]" {
			log.Println( "hidden-good-times-input", str )
			Data["hiddengoodtimesinput"] = make([]map[string]string, 0)
		} else {
			slice := []byte(str)
			err := json.Unmarshal(slice, &goodTimes)
			if err != nil {
				fatalError( "error.  report it", err, w )
				return

			}
			Data["hiddengoodtimesinput"] = goodTimes
		}

		var badTimes []map[string]string
		str = r.FormValue("hidden-bad-times-input")
		delete(Data, "hidden-bad-times-input")
		if str == "[]" {
			log.Println( "hidden-bad-times-input", str )
			Data["hiddenbadtimesinput"] = make([]map[string]string, 0)
		} else {
			slice := []byte(str)
			err := json.Unmarshal(slice, &goodTimes)
			if err != nil {
				fatalError( "error.  report it", err, w )
				return
			}
			Data["hiddenbadtimesinput"] = badTimes
		}
		log.Println("%+v\n", Data)

		//r.FormValue("hidden-good-times-input") = goodTime
		// categories = ["Development", "VIM"]
		// date = "2012-04-06"
		// description = "spf13-vim is a cross platform distribution of vim plugins and resources for Vim."
		// slug = "spf13-vim-3-0-release-and-new-website"
		// tags = [".vimrc", "plugins", "spf13-vim", "vim"]
		// title = "spf13-vim 3.0 release and new website"

		// Request Data
		// MIME Type: application/x-www-form-urlencoded
		// name: b
		// panelType: panelType.open
		// hidden-good-times-input: [{"id":"saturday_4pm_columbia-a/1"},{"id":"saturday_5pm_columbia-a/1"},{"id":"saturday_9pm_columbia-a/1"},{"id":"saturday_2pm_columbia-b/2"},{"id":"saturday_3pm_columbia-b/2"},{"id":"saturday_5pm_columbia-b/2"},{"id":"saturday_8pm_columbia-b/2"},{"id":"saturday_9pm_columbia-b/2"},{"id":"sunday_10am_columbia-a/1"},{"id":"sunday_11am_columbia-a/1"},{"id":"sunday_10am_columbia-b/2"},{"id":"sunday_11am_columbia-b/2"}]
		// hidden-bad-times-input: []
		// mc: a
		// title: c
		// tagline: d
		// description: e

		templateString := `
+++
name = "{{.name}}"
panelType = "{{.panelType}}"
hidden-good-times-input = {{.hiddengoodtimesinput}}
hidden-bad-times-input = {{.hiddenbadtimesinput}}
mc = "{{.mc}}"
title = "{{.title}}"
tagline = "{{.tagline}}"
+++
{{.description}}
`
		template, err := template.New("md").Parse(templateString)
		if err != nil {
			panic(err)
		}
		filePath := path.Join(outputDirectory, filename + ".md" )


		if _, err := os.Stat(filePath); err == nil {
			filePath = outputDirectory + "/" + time.Now().Format(time.RFC3339) + "_" + filename + ".md"

		}
		f, ferr := os.Create( filePath )
		if ferr != nil {
			fatalError( "failured to create file", ferr, w )
			return
		}
		err = template.Execute(f, Data)
		if err != nil {
			fatalError( "error during template execution.  report it", err, w )
			return
		}
		// go home son
		http.Redirect(w, r, r.Header.Get("Referer"), 302)

	})

	handler := formjson.Handler(h)
	http.ListenAndServe(":1314", handler)
}
