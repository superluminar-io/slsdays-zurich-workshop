GOPATH := $(shell go env GOPATH)

.PHONY: present
present: $(GOPATH)/bin/present
	$(GOPATH)/bin/present

$(GOPATH)/bin/present:
	go get golang.org/x/tools/cmd/present
