package main

import (
	"fmt"
	"github.com/kubernetes/kubernetes/pkg/kubelet/kubeletconfig/util/log"
	"github.com/sirupsen/logrus"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
)

func handler() {
	logrus.WithTime(time.Now().AddDate(-1, 0, 0)).Info("oops, one year ago.")
	fmt.Println("Just some text to STDOUT")
	log.Errorf("ARRRRGGGGGGG!!!!")
}

func main() {
	lambda.Start(handler)
}
