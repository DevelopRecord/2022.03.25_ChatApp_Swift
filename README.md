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
9. [User info](#User-Info)  
10. [Settings](#Settings)  
11. [Design](#Design)  
12. [Test account](#Test-account)   

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
     <td><img src="https://user-images.githubusercontent.com/76255765/168779608-02e820ae-07de-483e-b08b-1e194eef6bff.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168780376-7e268df0-6584-4c23-931f-4bbcf3c9e86f.png" width="200" height="400"></td>
  <tr>
</table>

## Main
이전에 대화한 모든 채팅방이 표시됩니다. Firebase의 Firestore의 message 경로에 접근하여 전체 현재 유저의 uid 도큐먼트의 전체 메시지 내역을 가져옵니다.  
각 대화방 별로 가장 최근의 대화 내용을 해당 유저의 uid 도큐먼트 경로에 recentMessages 컬렉션을 새로 생성하고 저장하여 채팅목록에 표시합니다.

<img src="https://user-images.githubusercontent.com/76255765/168793611-4a8046eb-a13a-43b1-9531-1cc46b89f487.png" width="200" height="400"/>

## Search
메인화면 오른쪽 하단 추가 버튼을 통해 현재 회원가입을 완료한 모든 유저를 표시합니다. 원하는 유저를 탭하면 채팅이 시작됩니다.  
또한 <code>UISearchResultsUpdating</code>을 사용하여 유저의 이름을 필터링해서 특정 유저를 검색하여 채팅을 시작할 수도 있습니다.

<img src="https://user-images.githubusercontent.com/76255765/168798383-2e9f61bc-1d10-4b27-8b2c-99a6fa20eb4f.png" width="200" height="400"/>

## Chat
Firestore의 messages컬렉션에서 uid별로 대화내역을 나누고, 대화 정보(보낸 이용자의 uid, 받은 이용자의 uid, text(메시지 내용), timestamp(발송 시간)를 저장합니다.  
메시지 전송 시 내가 보낸 메시지는 오른쪽에, 상대방이 보낸 메시지(프로필 사진, 닉네임, 텍스트)는 왼쪽에 배치하여 분류됩니다. 텍스트의 내용의 길이가 길 때 텍스트가 셀의 영역을 벗어나지 않기 위해 dynamic하게 지정하였습니다.
  
메시지 전송 시 TextView의 텍스트 값은 nil 처리하여 텍스트필드를 비우고 스크롤을 가장 아래로 이동하여 UI 편의성을 확대하였습니다.
최초에 채팅방에 들어간 후 메시지를 불러올 때 로딩 인디케이터를 표시합니다. 또한 텍스트 입력하지 않았을 때 전송 버튼 unable 처리하여 메시지 전송을 할 수 없게 처리하였습니다.

<table>
  <tr>
     <td><img src="https://user-images.githubusercontent.com/76255765/168972593-f0939b96-9b65-4708-ab6f-7d1fb43bb123.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168972602-956c4827-c8a3-4263-856f-3be8c1365441.png" width="200" height="400"></td>
  <tr>
</table>

## Profile
현재 로그인된 유저의 uid값을 이용하여 프로필 사진, 이름, 이메일 등을 표시합니다. UIView인 HeaderView, FooterView를 생성하여 테이블 뷰의 각각 Header, Footer 영역 그리고 가운데는 TableViewCell을 이용하여 UI를 구현하였습니다.

<code>Header</code>에는 프로필 사진, 닉네임을 표시하고 <code>Cell</code>에는 유저 정보(수정 및 회원탈퇴), 앱 설정을 구현하였으며, <code>Footer</code>에는 로그아웃 버튼을 구현하였습니다.

<img src="https://user-images.githubusercontent.com/76255765/168804731-170f9d44-6fb6-44e7-bc55-d94e0b7009fb.png" width="200" height="400"/>

## User info
유저의 정보 수정과 회원탈퇴 항목이 있습니다. 유저의 이메일 정보를 변경할 수 있고, 변경 완료 시 Toast메시지로 사용자에게 완료되었다는 메시지를 보여줍니다.
  
또한 회원탈퇴 cell을 클릭하여 회원탈퇴를 진행할 수 있으며 탈퇴 시 주의사항과 관련된 정보들을 <code>Property list</code>의 <code>Dictionary</code>를 사용하여 <code>Key</code>를 이용해 <code>Value</code>를 가져와서 불필요한 코드를 줄였습니다.

<table>
  <tr>
     <td><img src="https://user-images.githubusercontent.com/76255765/168805444-96fc82de-b5ce-4d5f-885f-23e8737528f3.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168805456-629f8cf1-8b6f-4fd7-9a74-0b67d9fb226d.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168805818-0042d1bc-b727-4dac-b1c7-7c3bdeb86be3.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168805834-c2034905-807e-4c07-9033-1a2d449a2d31.png" width="200" height="400"></td>
  <tr>
</table>

## Settings
푸시알림과 화면테마가 존재하며 현재 푸시알림은 개발중에 있습니다. 화면테마에는 밝은 모드, 어두운 모드, 시스템 설정과 같이 이렇게 세 개의 항목이 있으며, <code>UserDefaults</code>를 이용해 <code>indexPath.row</code>값을 저장하여 화면 설정의 상태를 저장합니다.  

또한 화면 설정 뷰가 나타나거나 앱을 종료 후 재실행해도 상태를 저장하여야 하기 때문에 <code>Lifecycle</code>와 <code>SceneDelegate</code>에 UserDefaults에 저장된 값을 불러오고 UI를 업데이트하는 함수를 호출합니다.  
마지막으로 선택한 화면 테마 모드를 사용자에게 보여줄 수 있게 <code>TableView</code>의 <code>isSelected</code>의 상태가 **true**인 cell <code>checkmark</code>로, **false**는 <code>.none</code>로 나타냅니다.

<table>
  <tr>
     <td><img src="https://user-images.githubusercontent.com/76255765/168975175-f83f0368-6991-4a59-b144-25acc933966d.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168975179-473b9b97-318f-4a24-a8c7-c2df5179708a.png" width="200" height="400"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/168975181-b8e3fd88-51b4-4229-877a-bac7c017b311.png" width="200" height="400"></td>
  </tr>
</table>

## Design
### Main color
ChatApp의 메인 컬러는 시스템 내장 컬러인 <code>.systemBlue</code>를 사용하였습니다.

<img src="https://user-images.githubusercontent.com/76255765/168977925-01a730c6-847a-4e23-83d9-df2292dd2ef1.png" width="612" style="border-radius:50%" />

### App icon

<img src="https://user-images.githubusercontent.com/76255765/169003442-528e1348-8b05-4b5b-9baf-7c2883ffec27.png" height="100" width="100" style="border-radius:50%" />

### UI / UX

<table>
  <tr>
     <td><img src="https://user-images.githubusercontent.com/76255765/169008098-1ca59c3f-968b-4696-9dea-c4299dd4f145.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169008108-3810a1e1-6af4-492c-933e-5d3a2303780b.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169008202-5dbe0997-df32-4289-b207-6cb9020972ff.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169008369-cb244d96-a886-4651-8e2d-53f0479ad06d.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169008286-3993349f-4e4d-4308-a4b4-5351f84c9bbc.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169008823-e410c484-e909-4ec4-8d77-d9eb3690a1ba.png" width="140" height="320"></td>
  </tr>
  <tr>
     <td><img src="https://user-images.githubusercontent.com/76255765/169008967-05d3f582-8576-4133-8446-4930420ae944.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169009044-2d5345c5-391f-4075-b9fa-d0b879237ccf.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169009150-0ecb473a-7035-47d9-9600-bcac5138f8ff.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169009163-8d876ebf-e0b7-401f-b070-f144e92d8e54.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169009212-1507c4fa-b73d-4f5d-84b8-83795478fdfe.png" width="140" height="320"></td>
     <td><img src="https://user-images.githubusercontent.com/76255765/169009685-9e2f57e3-0ecb-4e99-a8fd-07e73b6d5c4c.png" width="140" height="320"></td>
  </tr>
</table>

## Test account

ID: test@naver.com   
PW: qqqqqq
