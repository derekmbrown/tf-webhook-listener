package main

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context, event map[string]any) (string, error) {
	b, err := json.Marshal(event)
	if err != nil {
		return "", err
	}
	fmt.Printf("Event: %+v\n", string(b))
	return "Test", nil
}

func main() {
	lambda.Start(handler)
}
