package commands

import (
	"fmt"
	"testing"

	"github.com/h2non/gock"
)

func TestGetHelpWithResponseToHelpEndpoint(t *testing.T) {
	defer gock.Off()
	gock.New("http://localhost:3003/api/help")

	msg, str := Gethelp("http://localhost:3003/api/help")
	fmt.Println(msg)
	substring := ""
	if substring != str {
		t.Errorf("\n\nError: Str Should Only Be Filled If HTTP Status Code Less Than 400:\nStr Expected To Be: %q, Instead got %q\n\n", substring, str)
	}
}
