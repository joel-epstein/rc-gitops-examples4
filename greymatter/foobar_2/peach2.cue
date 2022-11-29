package foobar_2

import (
	gsl "greymatter.io/gsl/v1"

	"foobar_2.module/greymatter:globals"
)


Peach2: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Peach2.#NewContext & globals

	name:          "peach2"
	display_name:  "Peach2"
	version:       "v1.0.0"
	description:   "EDIT ME"
	
	api_endpoint:              "http://\(context.globals.edge_host)/services/foobar-2/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/foobar-2/\(name)/"
	business_impact:           "low"
	owner: ""
	capability: ""
	
	// Peach2 -> ingress to your container
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

	// Edge config for the Peach2 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge-foobar-2"
		routes: "/services/foobar-2/peach2": upstreams: (name): {
			gsl.#DefaultUpstream
			
		}
		
	}
}

exports: "peach2": Peach2
