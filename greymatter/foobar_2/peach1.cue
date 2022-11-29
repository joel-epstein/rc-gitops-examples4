package foobar_2

import (
	gsl "greymatter.io/gsl/v1"

	"foobar_2.module/greymatter:globals"
)


Peach1: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Peach1.#NewContext & globals

	name:          "peach1"
	display_name:  "Peach1"
	version:       "v1.0.0"
	description:   "EDIT ME"
	
	api_endpoint:              "http://\(context.globals.edge_host)/services/foobar-2/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/foobar-2/\(name)/"
	business_impact:           "low"
	owner: ""
	capability: ""
	
	// Peach1 -> ingress to your container
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


	
	// Edge config for the Peach1 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge-foobar-2"
		routes: "/services/foobar-2/peach1": upstreams: (name): {
			gsl.#DefaultUpstream
			
		}
	}
	
}

exports: "peach1": Peach1
