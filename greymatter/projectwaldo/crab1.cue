package projectwaldo

import (
	gsl "greymatter.io/gsl/v1"

	"projectwaldo.module/greymatter:globals"
)



Crab1: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Crab1.#NewContext & globals

	name:          "crab1"
	display_name:  "Crab1"
	version:       "v1.0.0"
	description:   "EDIT ME HELLO BLAH BLAH"
	
	api_endpoint:              "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/projectwaldo/\(name)/"
	business_impact:           "low"
	owner: ""
	capability: ""
	
	// Crab1 -> ingress to your container
	ingress: {
		"crab1": {
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

	// Edge config for the Crab1 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge-projectwaldo"
		edge_ingress: "edge-projectwaldo"
		routes: "/services/projectwaldo/crab1": upstreams: "\(name)": gsl.#DefaultUpstream
	}
}

exports: "crab1": Crab1
