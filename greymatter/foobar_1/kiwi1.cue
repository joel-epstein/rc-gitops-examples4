package foobar_1

import (
	gsl "greymatter.io/gsl/v1"

	"foobar_1.module/greymatter:globals"
)


Kiwi1: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Kiwi1.#NewContext & globals

	name:          "kiwi1"
	display_name:  "Kiwi1"
	version:       "v1.0.0"
	description:   "GREENLIGHT"
	
	api_endpoint:              "http://\(context.globals.edge_host)/services/foobar-1/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/foobar-1/\(name)/"
	business_impact:           "low"
	owner: ""
	capability: ""
	
	// Kiwi1 -> ingress to your container
	ingress: {
		(name): {
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

	// Edge config for the Kiwi1 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge-foobar-1"
		routes: "/services/foobar-1/kiwi1": upstreams: (name): {
			gsl.#DefaultUpstream
			
		}
		
	}
}

exports: "kiwi1": Kiwi1
