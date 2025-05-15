# ASP용 솔라피 알림톡 및 문자메시지 발송 코드

## [ASP 발송 관련 가이드 문서](https://developers.solapi.com/tutorial/2023/03/07/send-sms-and-process-report-using-classic-asp)를 참고해주세요.


KISA_HMAC.asp  
KISA_SHA256.asp  
index_HMAC.asp  
- SHA256 알고리즘 구현 코드(KISA제공)

aspJSON1.19.asp
- https://github.com/gerritvankuipers/aspjson

base64.asp
- Base 64 인코딩

config.asp
- API Key 정보, 서버 URL, 웹훅 보안키 입력, 디버그 출력
- config.dist.asp --> config.asp 변경

messages.asp
- 메시지발송, 이미지업로드

request.asp
- API 요청

utils.asp
- 기타 지원 코드

examples
- send_alimtalk.asp : 알림톡 발송 예제 (대체발송 X)
- send_alimtalk_sms.asp : 알림톡 실패 시 기본 문자로 대체 발송
- send_replacement.asp : 알림톡 실패 시 원하는 내용으로 대체 발송
- send_alimtalk_customfields.asp : 커스텀필드 사용 예시
- send_alimtalk_duplicates.asp : 중복 수신번호 허용 예제
- sms.asp : SMS 발송 예제
- lms.asp : LMS 발송 예제
- mms.asp : MMS 발송 예제
- messagelist.asp : 메시지 목록 조회
- webhook_report.asp : 웹훅 이벤트 처리 예제
- webhook_report_customfields.asp : 웹훅 커스텀필드 접근 예시
- get_balance.asp : 잔액 조회
- get_bankaccount.asp : 전용 계좌 정보 조회
