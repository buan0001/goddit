package neo4j

import (
	"context"
	"fmt"
	"github.com/neo4j/neo4j-go-driver/v5/neo4j"
	"log"
	"os"
)

type Neo4jDatabase struct {
	Driver neo4j.DriverWithContext
}

func NewNeo4jDatabase() *Neo4jDatabase {
	uri := os.Getenv("NEO4J_URI")
	username := os.Getenv("NEO4J_USERNAME")
	password := os.Getenv("NEO4J_PASSWORD")

	driver, err := neo4j.NewDriverWithContext(uri, neo4j.BasicAuth(username, password, ""))
	if err != nil {
		log.Fatalf("Failed to create Neo4j driver: %v", err)
	}

	if err := driver.VerifyConnectivity(context.Background()); err != nil {
		log.Fatalf("Failed to connect to Neo4j database: %v", err)
	}

	fmt.Println("Neo4j database connection established successfully!")

	return &Neo4jDatabase{Driver: driver}
}
