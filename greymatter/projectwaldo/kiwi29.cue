package projectwaldo

import (
	gsl "greymatter.io/gsl/v1"

	"projectwaldo.module/greymatter:globals"
)



Kiwi29: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Kiwi29.#NewContext & globals

	name:          "kiwi29"
	display_name:  "Kiwi29"
	version:       "v1.0.0"
	description:   "EDIT ME"
	
	api_endpoint:              "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	business_impact:           "low"
	owner: ""
	capability: ""
	
	// Kiwi29 -> ingress to your container
	ingress: {
		"kiwi29": {
			gsl.#HTTPListener
			
			
			
			routes: {
				"/": {
					upstreams: {
						"local": {
							
							
							instances: [
								{
									host: "127.0.0.1"
									port: 9090
								},
							]
						}
					}
				}
			}
		}
	}

	// Edge config for the Kiwi29 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge-projectwaldo"
		edge_ingress: "edge-projectwaldo"
		routes: "/services/projectwaldo/kiwi29": upstreams: "\(name)": gsl.#DefaultUpstream
	}
}

exports: "kiwi29": Kiwi29
