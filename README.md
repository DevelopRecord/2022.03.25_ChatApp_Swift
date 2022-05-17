# ChatApp
실시간 채팅 기능이 가능한 ChatApp으로 다양한 사람들과 채팅하고, 친해져 보세요.

## Chapter

1. [Library](#Library)   
2. [Framework](#Framework)   
3. [Preview](#Preview)   
4. [Login / Registration](#Login-/-Registration)  
5. [Main](#Main)  
6. [Search](#Search)  
7. [Chat](#Chat)  
8. [Profile](#Profile)  
9. [UserInfo](#UserInfo)  
10. [Settings](#Settings)  
11. [Test Account](#Test-Account)   

## Library   
|이름|목적|버전|
|:------:|:---:|:---:|
|Firebase|사용자, 메시지 정보 DB 저장|8.14.0|
|JGProgressHUD|로딩 표시|2.2.0|
|Kingfisher|URL 이미지 주소를 가진 이미지 불러오기|7.2.0|
|SnapKit|Auto Layout|5.0.0|
|SwiftyBeaver|디버깅|1.9.5|
|Then|클로저를 통한 인스턴스 생성 시 깔끔한 코드 작성|2.7.0|
   
## Framework
- UIKit
   
## Preview
<img src="https://user-images.githubusercontent.com/76255765/165462756-794724e8-9b49-42ba-9acd-a2d2d13b69f1.gif" width="400" height="510"/>
(미리보기 gif 공간)  

## Login / Registration
앱 실행 시 가장 먼저 보이는 화면입니다. MainController에서 로그인 유무를 판별하고 로그인이 되어 있지 않으면 여기로 이동합니다.  
Firestore에 유저 정보(프로필 사진, 아이디, 풀네임, 닉네임, uid) 저장합니다. 회원가입 정보 부정확(이메일 방식, 비밀번호 오타 등) 시 사용자에게 에러 메시지를 보여줍니다.  
기본적으로 <code>FirebaseAuth</code>를 사용하여 구현하였습니다.

<table>
  <tr>
     <td><img src="https://user-images.githubusercontent.com/76255765/168780363-a58352e9-00e1-42cf-91b4-f63eab121e95.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168779608-02e820ae-07de-483e-b08b-1e194eef6bff.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168779111-629fc84d-43e0-4bb0-85f7-753d5e90f39e.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168780376-7e268df0-6584-4c23-931f-4bbcf3c9e86f.png" width="200" height="400"></td>
  <tr>
</table>

## Main
이전에 대화한 모든 채팅방이 표시됩니다. Firebase의 Firestore의 message 경로에 접근하여 전체 현재 유저의 uid 도큐먼트의 전체 메시지 내역을 가져옵니다.  
각 대화방 별로 가장 최근의 대화 내용을 해당 유저의 uid 도큐먼트 경로에 recentMessages 컬렉션을 새로 생성하고 저장하여 채팅목록에 표시합니다.

<img src="https://user-images.githubusercontent.com/76255765/168793611-4a8046eb-a13a-43b1-9531-1cc46b89f487.png" width="200" height="400"/>

## Search
메인화면 오른쪽 하단 추가 버튼을 통해 현재 회원가입을 완료한 모든 유저를 표시합니다. 원하는 유저를 탭하면 채팅이 시작됩니다.

<img src="https://user-images.githubusercontent.com/76255765/168798383-2e9f61bc-1d10-4b27-8b2c-99a6fa20eb4f.png" width="200" height="400"/>

## Chat
Firestore의 messages컬렉션에서 uid별로 대화내역을 나누고, 대화 정보(보낸 이용자의 uid, 받은 이용자의 uid, text(메시지 내용), timestamp(발송 시간)를 저장합니다.  
메시지 전송 시 내가 보낸 메시지는 오른쪽에, 상대방이 보낸 메시지(프로필 사진, 닉네임, 텍스트)는 왼쪽에 배치하여 분류됩니다. 텍스트의 내용의 길이가 길 때 텍스트가 셀의 영역을 벗어나지 않기 위해 dynamic하게 지정하였습니다.
  
메시지 전송 시 TextView의 텍스트 값은 nil 처리하여 텍스트필드를 비우고 스크롤을 가장 아래로 이동하여 UI 편의성을 확대하였습니다.
최초에 채팅방에 들어간 후 메시지를 불러올 때 로딩 인디케이터를 표시합니다. 또한 텍스트 입력하지 않았을 때 전송 버튼 unable 처리하여 메시지 전송을 할 수 없게 처리하였습니다.

## Profile
현재 로그인된 유저의 uid값을 이용하여 프로필 사진, 이름, 이메일 등을 표시합니다. UIView인 HeaderView, FooterView를 생성하여 테이블 뷰의 각각 Header, Footer 영역 그리고 가운데는 TableViewCell을 이용하여 UI를 구현하였습니다.

<code>Header</code>에는 프로필 사진, 닉네임을 표시하고 <code>Cell</code>에는 유저 정보(수정 및 회원탈퇴), 앱 설정을 구현하였으며, <code>Footer</code>에는 로그아웃 버튼을 구현하였습니다.

회원탈퇴 주의사항 내용처럼 긴 텍스트를 plist의 dictionary에 담아 가져와서 불필요한 코드를 줄임

* 앱 설정
  * UserDefaults
  * 화면 테마(밝은 모드, 어두운 모드, 시스템 설정과 같이) 구현
  * 화면 테마 모드 정보를 UserDefaults에 저장하여 앱을 재실행해도 상태 저장
  * 선택한 화면 테마 모드를 사용자에게 보여줄 수 있게 TableView의 isSelected 상태의 cell을 Checkbox로 보여줌


   
#### 테스트계정

ID: test@naver.com   
PW: qqqqqq
