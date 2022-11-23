package projectwaldo

import (
	gsl "greymatter.io/gsl/v1"

	"projectwaldo.module/greymatter:globals"
)



Kiwi48: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Kiwi48.#NewContext & globals

	name:          "kiwi48"
	display_name:  "Kiwi48"
	version:       "v1.0.0"
	description:   "EDIT ME"
	
	api_endpoint:              "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	business_impact:           "low"
	owner: ""
	capability: ""
	
	// Kiwi48 -> ingress to your container
	ingress: {
		"kiwi48": {
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

	// Edge config for the Kiwi48 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge-projectwaldo"
		edge_ingress: "edge-projectwaldo"
		routes: "/services/projectwaldo/kiwi48": upstreams: "\(name)": gsl.#DefaultUpstream
	}
}

exports: "kiwi48": Kiwi48
