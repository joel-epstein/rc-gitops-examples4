// Edge configuration for enterprise mesh-segmentation. This is a dedicated
// edge proxy that provides north/south network traffic to services in this
// repository in the mesh. This edge would be separate from the default
// greymatter edge that is deployed via enterprise-level configuration in
// the gitops-core git repository.
package foobar_2

import (
	gsl "greymatter.io/gsl/v1"

	"foobar_2.module/greymatter:globals"
)

Edge: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Edge.#NewContext & globals

	name:              "edge-foobar-2"
	display_name:      "Foobar 2 Edge"
	version:           "v1.7.4"
	description:       "Edge ingress for foobar-2"
	api_endpoint:              "http://\(context.globals.edge_host)/services/foobar-2/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/foobar-2/\(name)/"
	business_impact:           "high"
	owner: ""
	capability: ""
	
	ingress: {
		// Edge -> HTTP ingress to your container
		(name): {
			gsl.#HTTPListener
			
			port: 10809
				

			routes: "/": upstreams: (name): gsl.#DefaultUpstream
		}
	}
}

exports: "edge-foobar-2": Edge
