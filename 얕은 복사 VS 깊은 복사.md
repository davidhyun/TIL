# 얕은 복사 VS 깊은 복사

## 1. 얕은 복사(Shallow Copy)

- **원본과 같은 메모리 주소값을 참조하는 복사**
- 새로운 인스턴스를 생성하지 않기 때문에 깊은 복사보다 상대적으로 빠르다.



## 2. 깊은 복사(Deep Copy)

- **인스턴스 자체를 통째로 새로 복사**
- **복사된 객체는 원본과 완전히 독립적인 메모리를 차지**

```python
import pandas as pd
import numpy as np
import torch
import copy


arr_origin = pd.Series([1,2,3,4,5]).to_numpy()

arr1 = arr_origin							# 얕은 복사 (원본 참조, 메모리 주소 공유)
arr2 = arr_origin.copy()					# 깊은 복사 (원본과 다른 메모리 할당)
arr3 = copy.copy(arr_origin)				# 깊은 복사 (원본과 다른 메모리 할당)
arr4 = copy.deepcopy(arr_origin)			# 깊은 복사 (원본과 다른 메모리 할당)


tensor1 = torch.tensor(arr_origin)			# 메모리 재할당(깊은 복사), infers the dtype automatically
tensor2 = torch.Tensor(arr_origin)			# 메모리 재할당(깊은 복사), return torch.FloatTensor
tensor3 = torch.FloatTensor(arr_origin)		# 메모리 재할당(깊은 복사)
tensor4 = torch.as_tensor(arr_origin)		# 원본 메모리 공유(상속)
tensor5 = torch.from_numpy(arr_origin)		# 원본 메모리 공유(상속)
```