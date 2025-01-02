import torch
print(torch.cuda.is_available())

print(torch.__version__)
print(torch.version.cuda)

n_gpu = torch.cuda.device_count()

print(n_gpu)