# 개인 과제 _ 인공지능 영상

## pytorch_tensor 주피터노트북

numpy로 행렬 연산을 쉽게 할 수 있다. 파이썬 라이브러리

행렬 생성

행렬 0, 1로 채워서 만들기

랜덤 수로 채운 행렬 생성

랜덤 정수로 채운 행렬 생성

인덱싱

행렬연산(합, 차, 곱, 상수곱, 평균, 전치)

파이토치

텐서에서 리스트나 넘파이어레이로 변경 가능

텐서연산 디바이스 지정

쿠다 또는 씨피유

파이토치에서 텐서(데이터)를 gpu 연산에 사용하려면 

텐서를 gpu에 올려야 한다

파이토치 텐서 다루기

- `torch.unsqueeze()`와 `torch.squeeze()`
- `torch.view()`와 `torch.reshape()`
- `torch.concat()`와 `torch.stack()`

모델 파라미터는 조금씩 변경하며 모델 학습 진행

    오차(loss)를 역전파하며 파라미터 업데이트 값 결정

경사하강법은 오차를 함수로 표현하고 미분하여 그 기울기를 구해 오차의 최솟값 방향으로 파라미터 값 업데이트

파이토치에서는 미분 계산을 자동으로 해준다. 모델의 파라미터를 담고 있는 텐서에 자동 미분을 하도록 설정하면 해당 텐서에 대한 미분값(그래디언트) 저장

## image_classification

Basic Neural Network 구현

데이터셋 내 데이터 시각화 함수 구현

- 이미지 데이터는 0에서 255사이의 픽셀값을 가짐

- 모델이 처리할 수 있는 텐서는 [-1, 1] 범위를 가짐

- 텐서로 변환하여 사용(정규화; data transformation 정의하여 사용)

cifar10으로 테스트

시각화 함수로 데이터 시각화 구현

- 시각화를 위해서 다시 정규화된 텐서에서 복원해야함

- 이후에 화면에 띄우는 작업 `visualize()` 구현

- 데이터셋 및 데이터 로더 불러와서 `visualize()` 함수 테스트 가능

Model 구성

- TwoLayerFC 모델, forward 연산 정의

- Linear Layer로 이미지를 flatten 

- Fully Connected Layer 모듈
  
  - FC1: input data -> hidden feature
  
  - ReLU
  
  - FC2: hidden feature -> output(각 클래스 별 classification 점수)
  
  - nn.Module 을 상속 받은 TwoLayerFC 모델의 _init_ 람수에 모델 레이어를 , forward 함수에 forward 연산을 정의하면 됨

모델 선언, 모델의 레이어 구성 확인, 모델의 파라미터 확인

모델 학습과정 구현

- train() 함수 구현

- 모델의 가중치가 업데이트 되는 과정이 학습과정임

- Optimizer를 초기화 하여 학습(조정) 하려는 모델 파라미터의 그래디언트를 리셋함

- 학습  loop 내에서
  
  - 모델 파라미터의 그래디언트를 리셋 `optimizer.zero_grad()`
  
  - model output 및 loss 계산
  
  - backpropagation `loss.backward()`, 파이토치에서 자동적으로 각 파라미터의 그래디언트를 계산해 저장함
  
  - 계산한 그래디언트를 이용해 파라미터를 업데이트함 `optimizer.step()`

- train() 함수에서 학습 loop 의 내용 구현

train() 함수 구현

- 각 데이터 배치 별 각 스텝 학습

- 초기화, 데이터 불러오기, 모델의 예측값 획득, 정답값과 차이구하기(loss)

- loss 를 backpropagation 하고 네트워크 가중치 업데이트
  
  -          # 1) Optimizer `optimizer`의 gradient 값을 초기화
    
            # 2) 배치 내 데이터를 불러오고 `device`로 데이터가 올라갈 디바이스를 지정함
    
            # 3) Forward pass를 통해 모델의 출력(예측값)을 생성함
    
            # 4) cross entropy loss를 계산함
    
            # 5) Loss를 backpropagation하여 gradient를 전달함
    
            # 6) optimizer로 네트워크 가중치를 업데이트함
    
            # 7) [Optional] 로깅 용으로 loss를 출력함                                                                      

모델 테스트 과정 구현

train모드 말고 eval 모드로 변경

그래디언트 계산이 불필요하므로 막음 : `torch.no_grad()`나 `@torch.no_grad()`

accuracy 계산하여 성능 측정

validation set과 test set에 대하여 측정

    # 1) 배치 내 데이터를 불러오고 `device`로 데이터가 올라갈 디바이스를 지정함

    # 2) Forward pass를 통해 모델의 출력(예측값)을 생성함

    # 3) `mode`가 validation(`val`)일 때는 loss 값을 계산함

    # 4) 예측한 클래스를 추출함(top-1). 예측값이 각 클래스의 점수이므로, 값이 최대인 클래스를 찾음

    # 5) 정답을 맞춘 개수를 누적합함

    # 6) Accurcy를 계산함

모델 학습 진행

- 학습 설정값 불러오고

- 데이터셋 및 데이터 로더 불러오고

- 종합하여 실행

- 1) 실행 디바이스 및 configuration 설정
  2) 이미지 데이터의 transform 정의하기
  3) 데이터로더 불러오기
  4) 모델을 선언하기
  5) 모델을 GPU에 올리기 (연산을 GPU로 하기 위함)
  6) Optimizer 선언하기: SGD 사용
  7) epoch만큼 반복하며 학습-평가를 수행하기: 한 epoch에서 학습 - 평가 순으로 수행하기

CNN 구현

- ThreeLayerConvNet 모델 구성 및 forward 연산 정의

- Convolution layer 5x5 필터, 2픽셀의 zero padding 사용

- ReLU 활성화함수

- Convolution layer 3x3 필터, 1픽셀의 zero padding 사용

- ReLU 활성화 함수

- Fully connent layer: 각 클래스 별 classification  점수로 매핑할 레이어

-         # 1) in_channel -> channel_1으로 가는 첫 번째 convolution layer 정의
  
          # 2) channel_1 -> channel_2으로 가는 두 번째 convolution layer 정의
  
          # 3) ReLU 활성화 함수 정의
  
          # 4) hidden feature를 클래스 별 분류 점수로 바꿀 FC layer 정의

- init 에서 정의한 레이어 및 모듈을 활용하여 이미지가 각 클래스 별 점수로 나오는 연산 수행

-         # 1) 입력 데이터를 Convolution layer 1, 2와 ReLU 레이어를 통과시키기
  
          # 2) hidden features를 [batch크기, 각 feature 크기] 형태로 바꾸기
  
          # 3) FC layer를 거쳐 최종 출력(각 클래스 별 classification 점수)인 리턴값을 구하기

모델 학습 진행하기

- 학습에 사용할 설정값, 데이터셋 , 데이터 로더 불러오고

- 모델 및 optimizer 선언하고 학습 iteration 수행과정 구현

- 종합하여 실행

- 1) 실행 디바이스 및 configuration 설정
  2) 이미지 데이터의 transform 정의하기
  3) 데이터로더 불러오기
  4) 모델을 선언하기
  5) 모델을 GPU에 올리기 (연산을 GPU로 하기 위함)
  6) Optimizer 선언하기: SGD 사용
  7) epoch만큼 반복하며 학습-평가를 수행하기: 한 epoch에서 학습 - 평가 순으로 수행하기

더 높은 정확도의 이미지 분류기 모델 만들기

- 시도 가능한 것은?

- 모델 구조 (레이어의 구성): Convolution layer의 개수와 입출력 채널 차원 크기, 커널 크기, 패딩 종류 및 크기, pooling layer의 종류와 크기, Fully connected layer의 입력 채널 차원 및 층 개수 등

- 최적화 기법: Adam, AdamW, SGD, RMSprop 등

- 하이퍼파라미터: 배치 크기, 학습률(learning rate) 등

- 정규화 (normalization): 배치 정규화, 레이어 정규화, 그룹 정규화 등

- 활성화함수: ReLU, LeakyReLU, GELU, Sigmoid 등

- 데이터 증강 (augmentation): 뒤집기(flip), 랜덤 자르기(random crop) 등



## Attention

데이터 전처리를 위한 가상의 데이터 생성

padding 함수 구현 (데이터의 길이를 균일하게 맞춰주는 함수)

- 배치 내 데이터 중 최대 길이에 맞도록 다른 데이터의 마지막에 임의의 패딩 값을 패딩함

-     # 1) 가장 긴 데이터의 길이 추출
  
      # 2) 모든 데이터를 돌면서 1에서 구한 길이에 맞게 뒷부분을 pad_value로 채우기
  
  

Single-head Self-Attention 구현

- 임베딩 및 쿼리, 키, 밸류 벡터 구하기
  
  - 토큰화된 입력 데이터가 임베딩 과정을 거쳐 임베딩 공간의 d_k 차원으로 프로젝션 되어 임베딩 벡터를 각각 d_k 차원을 가지는 3개의 벡터로 만들어야함 파이토치의 nn.linear 모듈 이용

- Scaled Dot-Product Self-Attention 구현
  
  - 각 head에서 진행하는 Q, K, V의 Self-attention을 구현하겠습니다.
  
  - 가장 먼저, 쿼리와 키(의 전치) 벡터를 곱한 뒤, 벡터 차원의 제곱근으로 나눕니다. 해당 과정은 같은 sequence 내에 서로 다른 token들에게 얼마나 가중치를 두고 attention을 해야하는가를 연산합니다.
  
  - 그 값에 softmax 함수를 취합니다.
  
  - 그 값에 밸류 벡터를 곱하여 최종 attention matrix를 얻습니다.
  
  - 1) Query 벡터와 Key 벡터의 전치를 곱하고, 벡터 차원의 제곱근으로 나눔 (=(Q x K^T) / sqrt(d_k))
    2) 위 값에 softmax를 취함. row-wise이기 때문에 dim은 -1 로 적용할 것.
    3) Value 벡터를 곱해 최종 attention value 계산



Multi-Head Self-Attention 구현하기

- Single-head 코드를 바탕으로 multi-head self-attention을 구현하겠습니다. 전체적으론 아래 내용이 변경 혹은 추가되어야 합니다.

- Q, K, V를 (임베딩 벡터 차원) x (head 개수) 차원으로 projection한 뒤 각 head 개수로 쪼개 사용합니다.
  임베딩 과정에서 입력 데이터를 임베딩 공간의 d_model 차원으로 projection합니다.
  해당 d_model 값은 어텐션 헤드의 개수(n_heads)로 나누어 떨어져야 합니다.
  각 헤드의 연산을 한 뒤에는 각 헤드별로 가중치를 곱해 최종 attention value를 구합니다

- 상세과정

- 1) vocab_size 개수의 데이터 각각을 d_model 차원으로 표현할 임베딩을 할 레이어 정의
  2) 임베딩 레이어를 사용하여 입력 데이터를 임베딩 벡터로 projection
  3) d_model 차원의 Q, K, V 벡터를 만들 레이어 정의
  4) 임베딩 벡터를 Q, K, V 벡터로 변환
  5) d_k 차원 계산
  6) Q, K, V 벡터를 각 헤드만큼 쪼갬 (각 헤드의 각 벡터 차원은 d_k)
  7) Self-attention 연산을 위하여 각 헤드가 (L, d_k) 행렬을 갖도록 축을 transpose

- 상세과정

- 1) Query 벡터와 Key 벡터의 전치를 곱하고, 벡터 차원의 제곱근으로 나눔 (=(Q x K^T) / sqrt(d_k))
  2) 위 값에 softmax를 취함. row-wise이기 때문에 dim은 -1 로 적용할 것.
  3) Value 벡터를 곱해 최종 attention value 계산

Attention heads의 결과물 병합

- 각 attention head의 결과물을 concatenate해 병합하고, head 별로 정해진 가중치로 linear projection하여 최종 출력을 결정합니다.
  
  이 linear projection은 서로 다른 의미로 focusing된 각 head의 self-attention 정보를 합치는 역할을 합니다.

- 상세 과정

- 1) Scaled dot-product 의 결과(attn_values)를 (B, L, num_heads, d_k) 형태로 축 변경
  2) 각 head의 점수를 concatenate함
  3) 각 head마다의 가중치를 부여할 linear layer 정의
  4) 위 linear projection layer를 통과하여 최종 출력을 계산

Multi-Head Self-Attention의 모듈 클래스 구현

앞선 <Req. 3-4> ~ <Req. 3-6>의 multi-head self-attention 구현 과정을 하나의 모듈 클래스로 만들어 처리를 손쉽게 구현하겠습니다.

해당 클래스의 forward 연산에서는 임베딩 벡터를 입력으로 받아 multi-head self-attention 결과를 출력하도록 합니다.

2) 임베딩 벡터를 Q, K, V 벡터로 변환할 레이어 정의

3) 각 헤드의 결과에 가중치를 부여할 linear layer 정의

        # 1) Query 벡터와 Key 벡터의 전치를 곱하고, 벡터 차원의 제곱근으로 나눔 (=(Q x K^T) / sqrt(d_k))

        # 2) 위 값에 softmax를 취함. row-wise이기 때문에 dim은 -1 로 적용할 것.

        # 3) Value 벡터를 곱해 최종 attention value 계산

---

       # 1) 입력 데이터를 Q, K, V 벡터로 변환

        # 2) 위 결과를 Head의 수로 분할함

        # 3) 각 head가 (L, d_k)의 matrix를 담당하도록 만듦

        # 4) Scaled dot-product self-attention 연산을 수행함

        # 5) 각 attention head의 결과물을 concatenate해 병합함

        # 6) head 별로 정해진 가중치로 linear projection하여 최종 출력을 결정함