package globals

import (
	gsl "greymatter.io/gsl/v1"
)

globals: gsl.#DefaultContext & {
	edge_host: "a548dc03f8f11464d8ddc651e4d737a8-338444494.us-east-1.elb.amazonaws.com:10809"
	namespace: "examples"
	
	// Please contact your mesh administrators as to what
	// values must be set per your mesh deployment.
	mesh: {
		name: string
	}
}
