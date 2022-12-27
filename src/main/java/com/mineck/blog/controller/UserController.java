package com.mineck.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mineck.blog.model.KakaoProfile;
import com.mineck.blog.model.OAuthToken;
import com.mineck.blog.model.User;
import com.mineck.blog.service.UserService;

@Controller
public class UserController {
	
	@Value("${mineck.key}")
	private String mineckKey;

	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Autowired
	private UserService userService;

	@GetMapping("/auth/joinForm")
	public String joinForm() {

		return "user/joinForm";
	}

	@GetMapping("/auth/loginForm")
	public String loginForm() {

		return "user/loginForm";
	}

	@GetMapping("/auth/kakao/callback")
	public String kakaoCallback(String code) {

		// HTTP header object
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// HTTP body object
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "f79eb714124f6d245b6d02d581fb94ff");
		params.add("redirect_url", "http://localhost:8000/auth/kakao/callback");
		params.add("code", code);

		// header, body throw one object
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

		// request HTTP (post)
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				kakaoTokenRequest, String.class);

		// token mapping
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		// HTTP header object
		RestTemplate rt2 = new RestTemplate();
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// header, body throw one object
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);

		// request HTTP (post)
		ResponseEntity<String> response2 = rt2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				kakaoProfileRequest, String.class);

		// token mapping
		ObjectMapper objectMapper2 = new ObjectMapper();
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		System.out.println("카카오 아이디(번호) : " + kakaoProfile.getId());
		System.out.println("카카오 이메일 : " + kakaoProfile.getKakao_account().getEmail());

		System.out.println("블로그서버 유저네임 : " + kakaoProfile.getKakao_account().getEmail() + "_" + kakaoProfile.getId());
		System.out.println("블로그서버 이메일 : " + kakaoProfile.getKakao_account().getEmail());
		System.out.println("블로그서버 패스워드 : " + mineckKey);

		User kakaoUser = User.builder()
				.username(kakaoProfile.getKakao_account().getEmail() + "_" + kakaoProfile.getId())
				.password(mineckKey)
				.email(kakaoProfile.getKakao_account().getEmail())
				.oauth("kakao")
				.build();

		User originUser = userService.회원찾기(kakaoUser.getUsername());

		if (originUser.getUsername() == null) {
			System.out.println("기존 회원이 아니기에 자동 회원가입을 진행합니다");
			userService.회원가입(kakaoUser);
		}

		System.out.println("자동 로그인을 진행합니다");
		Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(kakaoUser.getUsername(), mineckKey));
		SecurityContextHolder.getContext().setAuthentication(authentication);

		return "redirect:/";
	}

	@GetMapping("/user/updateForm")
	public String updateForm() {

		return "user/updateForm";
	}
}
