package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/aws/aws-lambda-go/lambda"
)

type DiscordPayload struct {
	Username   string `json:"username"`
	Avatar_url string `json:"avatar_url"`
	Content    string `json:"content"`
}

type Payload struct {
	Alarm     Alarm `json:"alarm"`
	Timestamp int64 `json:"timestamp"`
}

type Alarm struct {
	Name       string    `json:"name"`
	Sources    []any     `json:"sources"`
	Conditions []any     `json:"conditions"`
	Triggers   []Trigger `json:"triggers"`
}

type Trigger struct {
	Key       string `json:"key"`
	Device    string `json:"device"`
	EventID   string `json:"eventId"`
	Timestamp int    `json:"timestamp"`
}

func handler(ctx context.Context, event map[string]any) (bool, error) {
	printJson(event)
	fmt.Println(event["body"])
	fmt.Println(event["alarm"])

	bodyBytes := []byte(event["body"].(string))

	var payload Payload
	json.Unmarshal(bodyBytes, &payload)

	var payloadStr string
	for _, trigger := range payload.Alarm.Triggers {
		// payloadStr = fmt.Sprintf("%d -- %s", trigger.Timestamp, trigger.Key)
		payloadStr = fmt.Sprintf("%s", trigger.Key)
	}

	p := DiscordPayload{
		Username:   "Unifi Protect Events API",
		Avatar_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK8a1v3kXSwstVCq9oZQjV1-IGVwL0Mdc9bA&s",
		Content:    payloadStr,
	}

	payloadBytes, _ := json.Marshal(p)
	resp, err := http.Post(
		"https://discord.com/api/webhooks/1392265163419160626/yrI6ZPBB0axnWP6J3w3WTnpK5WZ4PTiVnEVMyNVioH0u5SqjDHPv_peCPVUTng7l3s7N",
		"application/json",
		bytes.NewReader(payloadBytes),
	)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}
	fmt.Println("Response:", string(body))

	return true, nil
}

func main() {
	lambda.Start(handler)
}

func printJson(event map[string]any) {
	e, _ := json.Marshal(event)
	fmt.Printf("Event: %+v\n", string(e))
}
