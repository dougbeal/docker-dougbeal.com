package main

import (
	"encoding/json"
	"fmt"
	"github.com/rs/formjson"
	"log"
	"net/http"
	"net/http/httputil"
	"os"
	"text/template"
)

func main() {
	h := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		inputFields := []string{"name", "panelType", "hidden-good-times-input", "hidden-bad-times-input", "mc", "title", "tagline", "description"}
		//body := fmt.Sprintf("Hello %s! t %s", r.FormValue("name"), r.FormValue("title"), r.FormValue("hidden-good-times-input"))
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
				http.Error(w, fmt.Sprint(err), http.StatusInternalServerError)
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
				http.Error(w, fmt.Sprint(err), http.StatusInternalServerError)
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
		err = template.Execute(os.Stdout, Data)
		d1 := []byte("hello\ngo\n")
		err := ioutil.WriteFile("/tmp/dat1", d1, 0644)
		check(err)		
	
	})

	handler := formjson.Handler(h)
	http.ListenAndServe(":1314", handler)
}
