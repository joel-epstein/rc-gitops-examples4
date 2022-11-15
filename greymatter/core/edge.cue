// Edge configuration for enterprise mesh-segmentation. This is a dedicated
// edge proxy that provides north/south network traffic to services in this
// repository in the mesh. This edge would be separate from the default
// greymatter edge that is deployed via enterprise-level configuration in
// the gitops-core git repository.
package projectwaldo

import (
	gsl "greymatter.io/gsl/v1"

	"projectwaldo.module/greymatter:globals"
)

Edge: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Edge.#NewContext & globals

	name:              "edge-projectwaldo"
	display_name:      "Edge Projectwaldo"
	version:           "v1.7.4"
	description:       "EDIT ME: Edge ingress for projectwaldo"
	api_endpoint:              "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	business_impact:           "high"
	owner: ""
	capability: ""
	
	ingress: {
		// Edge -> HTTP ingress to your container
		"edge-projectwaldo": {
			gsl.#HTTPListener
			
			port: 10809
			routes: "/": upstreams: "\(name)": gsl.#DefaultUpstream
			
		}
	}
}

exports: "edge-projectwaldo": Edge
