package globals

import (
	gsl "greymatter.io/gsl/v1"
)

globals: gsl.#DefaultContext & {
	edge_host: "a5718002c00314d6bb844b05268c091f-1853430095.us-east-1.elb.amazonaws.com:10809"
	namespace: "examples"
	
	// Please contact your mesh administrators as to what
	// values must be set per your mesh deployment.
	mesh: {
		name: string
	}
}
