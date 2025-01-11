package com.johnnyb.elkproject.api;

import io.quarkus.test.junit.QuarkusTest;
import io.restassured.RestAssured;
import org.junit.jupiter.api.Test;

import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
public class LoggingResourceTest {

    @Test
    public void testGeneralLogEndpoint() {
        RestAssured
            .given()
            .when()
            .get("/log")
            .then()
            .statusCode(200)
            .body(is("General log messages generated!"));
    }

    @Test
    public void testSpecificLogEndpoint() {
        RestAssured
            .given()
            .when()
            .get("/log/specific")
            .then()
            .statusCode(200)
            .body(is("Specific log messages generated!"));
    }
}
