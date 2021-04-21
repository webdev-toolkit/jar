package in.webdevtoolkit.backend;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@SpringBootTest
class BackendApplicationTests {

	@Test
	void contextLoads() {

		List<String> test = new ArrayList<>();
		test.add("ABCb");
		test.add("DEF");
		test.add("PQR");

		List<Character> a = test.stream()
				.flatMap(string -> string.chars().mapToObj(i -> (char)i))
				.filter(c -> c < 90).collect(Collectors.toList());



	}

}
