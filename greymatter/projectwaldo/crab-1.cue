package projectwaldo

import (
	gsl "greymatter.io/gsl/v1"

	"projectwaldo.module/greymatter:globals"
)



Crab-1: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Crab-1.#NewContext & globals

	name:          "crab-1"
	display_name:  "Crab-1"
	version:       "v1.0.0"
	description:   "EDIT ME"
	
	api_endpoint:              "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	business_impact:           "low"
	owner: ""
	capability: ""
	
	// Crab-1 -> ingress to your container
	ingress: {
		"crab-1": {
			gsl.#HTTPListener
			
			
			
			routes: {
				"/": {
					upstreams: {
						"local": {
							
							
							instances: [
								{
									host: "127.0.0.1"
									port: 443
								},
							]
						}
					}
				}
			}
		}
	}

	// Edge config for the Crab-1 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge-projectwaldo"
		edge_ingress: "edge-projectwaldo"
		routes: "/services/projectwaldo/crab-1": upstreams: "\(name)": gsl.#DefaultUpstream
	}
}

exports: "crab-1": Crab-1
