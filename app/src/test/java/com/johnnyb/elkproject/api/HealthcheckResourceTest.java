package com.johnnyb.elkproject.api;

import io.quarkus.test.junit.QuarkusTest;
import io.restassured.RestAssured;
import org.junit.jupiter.api.Test;

import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
public class HealthcheckResourceTest {

    @Test
    public void testGeneralLogEndpoint() {
        RestAssured
            .given()
            .when()
            .get("/healthcheck")
            .then()
            .statusCode(200)
            .body(is("Healthcheck"));
    }

}
