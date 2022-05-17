# ChatApp
## 목차

1. [Library](#Library)   
2. [Framework](#Framework)   
3. [Preview](#Preview)   
4. [Login / Registration](#Login-/-Registration)  
5. [Home](#Home)  
6. [Search](#Search)  
7. [Profile](#Profile)  
8. [UserInfo](#UserInfo)  
9. [Settings](#Settings)  
10. [Test Account](#Test-Account)   

#### Library   
|이름|목적|버전|
|:------:|:---:|:---:|
|SnapKit|Auto Layout|5.0.0|
|Kingfisher|URL 이미지 주소를 가진 이미지 불러오기|7.2.0|
|Firebase|사용자, 메시지 정보 DB 저장|8.14.0|
|SwiftyBeaver|디버깅|1.9.5|
|JGProgressHUD|로딩 표시|2.2.0|
   
#### Framework
- UIKit
   
#### Preview
메인화면의 +버튼을 누르고 다른사람과 채팅을 나눌 수 있습니다.   
![ChatApp-preview](https://user-images.githubusercontent.com/76255765/165462756-794724e8-9b49-42ba-9acd-a2d2d13b69f1.gif)
   
#### 기능
   
* 로그인
  * Firebase
  * DB에 저장된 유저 정보로 로그인
  * 로그인 정보 부정확 시 에러 메시지 알림

* 회원가입
  * Firestore
  * DB에 유저 정보(프로필 사진, 아이디, 풀네임, 닉네임, uid) 저장
  * 회원가입 정보 부정확 시 에러 메시지 알림

* 채팅
  * Firebase
  * DB에 대화 상대 정보(보낸 이용자의 uid, 받은 이용자의 uid, text(메시지 내용), timestamp(발송 시간) 저장
  * DB에 최근 메시지 상태 따로 저장
  * 채팅 목록에 최근 메시지 리스트 표시
  * 메시지 전송 시 내가 보낸 메시지는 오른쪽, 상대방이 보낸 메시지는 왼쪽 표시(프로필 사진, 닉네임, 텍스트)
  * 메시지 전송 시 TextView의 텍스트 값은 nil 처리하여 텍스트 비우기
  * 텍스트의 내용의 길이가 길 때 셀의 높이를 dynamic하게 지정
  * 메시지 전송 시 스크롤을 가장 아래로 이동
  * 메시지 불러올 때 로딩창 표시
  * 텍스트 입력하지 않았을 때 전송 버튼 unable 처리

* 앱 설정
  * UserDefaults
  * 화면 테마(밝은 모드, 어두운 모드, 시스템 설정과 같이) 구현
  * 화면 테마 모드 정보를 UserDefaults에 저장하여 앱을 재실행해도 상태 저장
  * 선택한 화면 테마 모드를 사용자에게 보여줄 수 있게 TableView의 isSelected 상태의 cell을 Checkbox로 보여줌

* 프로필 정보
  * Firebase
  * DB에 저장된 유저 정보(프로필 사진, 풀네임, 닉네임)로 표시
  * HeaderView를 UIView로 따로 생성하여 추가
  * 로그아웃 기능
  * 유저 정보 수정 구현(이메일)
  * 회원탈퇴 기능 구현
  * 회원탈퇴 주의사항 내용처럼 긴 텍스트를 plist의 dictionary에 담아 가져와서 불필요한 코드를 줄임
   
#### 테스트계정

ID: test@naver.com   
PW: qqqqqq
