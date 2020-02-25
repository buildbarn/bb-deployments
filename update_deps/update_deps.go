package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"path/filepath"
	"regexp"
	"strings"

	"github.com/google/go-containerregistry/pkg/crane"
)

var (
	root = flag.String("repo_root", ".", "The base directory of the repository.")
)

func main() {
	flag.Parse()

	potRoot, err := filepath.Abs(*root)
	if err != nil {
		log.Fatalf("Error building absolute path for %s: %s", root, err)
	}
	root = &potRoot

	fmt.Println("Repo root:", *root)

	files := []string{
		"ci/docker-compose-build.yml",
		"ci/docker-compose.yml",
		"docker-compose/docker-compose.yml",
		"kubernetes/browser.yaml",
		"kubernetes/event-service.yaml",
		"kubernetes/frontend.yaml",
		"kubernetes/scheduler.yaml",
		"kubernetes/storage.yaml",
		"kubernetes/worker-ubuntu16-04.yaml",
	}
	fmt.Println(strings.Join(files, "\n"))

	imageUrls := regexp.MustCompile(`image: (?P<url>\S+)`)

	options := []crane.Option{}

	cache := make(map[string][]string)

	// We could do files in parallel
	// and use a sync Map
	// but this is a script, it's probably fast enough
	for _, file := range files {
		if file == "update_deps/update_deps.go" {
			// Let's not process ourselves
			// It'd probably be better to match certain extensions
			// like .ya?ml
			continue
		}
		file = filepath.Join(*root, file)
		fmt.Println("Processing", file)
		contents, err := ioutil.ReadFile(file)
		if err != nil {
			log.Fatalf("Error reading %s: %s", file, err)
		}
		newContents := string(contents)
		for _, matches := range imageUrls.FindAllSubmatch(contents, -1) {
			url := string(matches[1])
			parts := strings.Split(url, ":")
			repo := parts[0]
			if cache[repo] == nil {
				fmt.Println("Fetching tags for", repo)
				// We could keep a cache of repos we've fetched already
				// so we don't have to fetch them multiple times
				tags, err := crane.ListTags(repo, options...)
				if err != nil {
					log.Fatalf("Listing tags for %s: %v", repo, err)
				}
				cache[repo] = tags
				// fmt.Println(tags)
			}
			tags := cache[repo]
			i := len(tags) - 1
			var tag string
			for {
				tag = tags[i]
				if tag != "latest" {
					break
				}
				i--
			}
			// The above logic doesn't work for busybox, so
			// let's just hardcode it
			// We don't need to fetch the tags for it in that case,
			// so we could fix that
			if repo == "busybox" {
				tag = "1.31.1"
			}
			newUrl := fmt.Sprintf("%s:%s", repo, tag)
			newContents = strings.ReplaceAll(string(contents), url, newUrl)
		}
		err = ioutil.WriteFile(file, []byte(newContents), 0644)
		if err != nil {
			log.Fatalf("Error writing %s: %s", file, err)
		}
	}

	// TODO(zoidbergwill): Maybe use this to pin digests too
	// latest := *repository + ":latest"
	// latestDigest, err := crane.Digest(latest, options...)
	// if err != nil {
	// 	log.Fatalf("Computing digest for %s: %v", latest, err)
	// }
}
